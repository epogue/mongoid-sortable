require 'spec_helper'

shared_examples_for 'a sortable item' do
	it { document1.position.should == 1 }
	it { document2.position.should == 2 }
	it { document3.position.should == 3 }

	it "should get the next item" do
		document2.next.should == document3
	end

	it "should get the previous item" do
		document2.previous.should == document1
	end

	it "should be positioned at new position" do
		document1.position_at(2)
		document1.reload.position.should == 2
	end

	it "should reposition others when repositioned" do
	  document1.position_at(2)
	  document2.reload.position.should == 1
	  document3.reload.position.should == 3
	end

	it "should reposition others when destroyed" do
	  document1.destroy
	  document2.reload.position.should == 1
	  document3.reload.position.should == 2
	end

	it "should reorder items when given an array" do
		the_order = [document2.id.to_s, document3.id.to_s, document1.id.to_s]
		document1.reorder(the_order)
		document1.reload.position.should == 3
		document2.reload.position.should == 1
	  document3.reload.position.should == 2
	end
end