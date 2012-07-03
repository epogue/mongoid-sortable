require 'mongoid-sortable/version'
require 'active_support/concern'

module Mongoid
  module Sortable
    extend ActiveSupport::Concern
    
    included do
      cattr_accessor :mongoid_sortable_options
      self.mongoid_sortable_options = {}

      field :position, type: Integer, default: 1
      
      before_create :set_position
      after_destroy :set_sibling_positions
    end

    module ClassMethods
      def sortable(options = {})
        options = {
          scope: []
        }.merge(options)

        options[:scope].map!(&:to_sym)

        self.mongoid_sortable_options = options
      end
    end
    
    def previous
      position_scope.lt(position: position).order_by('position desc').first
    end
    
    def next
      position_scope.gt(position: position).order_by('position asc').first
    end
    
    def reorder(ids)
      ids.map!(&:to_s) # ensure entities are strings
      ids.each_with_index do |id, index|
        position_scope.find(id).set(:position, index + 1)
      end
    end
    
    def position_at(new_position)
      position_scope.gt(position: position).each{|d| d.inc(:position, -1) }
      set(:position, nil)
      position_scope.gte(position: new_position).each{|d| d.inc(:position, 1) }
      set(:position, new_position)
    end
        
    def set_position
      self.position = position_scope.count + (embedded? ? 0 : 1)
    end
    
    def set_sibling_positions
      position_scope.gt(position: position).each{|d| d.inc(:position, -1) }
    end

    def relation
      (embedded? ? send(self.metadata.inverse).send(self.metadata.name) : self.class).unscoped.scoped
    end

    def position_scope(options = {})
      scopes = Array(mongoid_sortable_options[:scope])
      scopes.inject(relation) do |criteria, scope_field|
        criteria.where(scope_field => self.send(scope_field))
      end
    end
  end
end