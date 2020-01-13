require 'mongoid-sortable'

class ParentDocument
	include Mongoid::Document

	has_many :documents
end

class Document
	include Mongoid::Document
	include Mongoid::Sortable

	belongs_to :parent_document, optional: true
	embeds_many :embedded_documents
	sortable scope: [:parent_document_id]
end

class EmbeddedDocument
	include Mongoid::Document
	include Mongoid::Sortable

	embedded_in :document
	sortable
end