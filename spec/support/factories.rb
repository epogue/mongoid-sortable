require 'factory_girl'

FactoryGirl.define do
	factory :parent_document do
		trait :with_documents do
			after(:create) do |parent, evaluator|
				3.times { FactoryGirl.create(:document, parent_document: parent) }
			end
		end
	end

	factory :document do
		trait :with_embedded_docs do
			after(:create) do |parent, evaluator|
				3.times { FactoryGirl.create(:embedded_document, document: parent) }
			end
		end
	end

	factory :embedded_document
end