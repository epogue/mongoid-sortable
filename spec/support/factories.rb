require 'factory_bot'

FactoryBot.define do
	factory :parent_document do
		trait :with_documents do
			after(:create) do |parent, evaluator|
				3.times { FactoryBot.create(:document, parent_document: parent) }
			end
		end
	end

	factory :document do
		trait :with_embedded_docs do
			after(:create) do |parent, evaluator|
				3.times { FactoryBot.create(:embedded_document, document: parent) }
			end
		end
	end

	factory :embedded_document
end