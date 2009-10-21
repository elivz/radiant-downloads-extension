require File.dirname(__FILE__) + '/../spec_helper'

describe DownloadFolder do
  before(:each) do
    @download_folder = DownloadFolder.new
  end

  it "should be valid" do
    @download_folder.should be_valid
  end
end
