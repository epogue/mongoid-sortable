require 'spec_helper'

describe "MongoidSortable" do
	describe "sortable items" do
		let(:parent) { FactoryBot.create(:parent_document) }
		let!(:document1) { FactoryBot.create(:document, parent_document: parent) }
		let!(:document2) { FactoryBot.create(:document, parent_document: parent) }
		let!(:document3) { FactoryBot.create(:document, parent_document: parent) }

		it_should_behave_like 'a sortable item'

		it "should properly sort" do
			parent.documents.order_by('position asc').to_a.should == [document1, document2, document3]
		end

		context "with distinct parents" do
		  let(:parent1) { FactoryBot.create(:parent_document) }
		  let(:parent2) { FactoryBot.create(:parent_document) }
		  let!(:p1_doc1) { FactoryBot.create(:document, parent_document: parent1) }
		  let!(:p1_doc2) { FactoryBot.create(:document, parent_document: parent1) }
			let!(:p2_doc1) { FactoryBot.create(:document, parent_document: parent2) }
			let!(:p2_doc2) { FactoryBot.create(:document, parent_document: parent2) }

			it "should have their proper positions" do
			  p1_doc1.position.should == 1
			  p1_doc2.position.should == 2
			  p2_doc1.position.should == 1
			  p2_doc2.position.should == 2
			end

			it "should scope previous/next" do
			  p1_doc1.next.should == p1_doc2
			  p1_doc2.previous.should == p1_doc1
			  p2_doc1.next.should == p2_doc2
			  p2_doc2.previous.should == p2_doc1
			end

			it "should scope position_at" do
			  p1_doc1.position_at(2)
			  p1_doc1.reload.position.should == 2
			  p1_doc2.reload.position.should == 1
			  p2_doc1.reload.position.should == 1
			  p2_doc2.reload.position.should == 2
			end
		end
	end

	describe "sortable embedded documents" do
		let(:parent) { FactoryBot.create(:document) }
		let!(:document1) { FactoryBot.create(:embedded_document, document: parent) }
		let!(:document2) { FactoryBot.create(:embedded_document, document: parent) }
		let!(:document3) { FactoryBot.create(:embedded_document, document: parent) }
		
		it_should_behave_like 'a sortable item'

		it "should properly sort" do
			parent.embedded_documents.order_by('position asc').to_a.should == [document1, document2, document3]
		end
	end
end