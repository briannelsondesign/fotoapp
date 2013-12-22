require "spec_helper"

describe Foto::PhotoUploader do
  let(:photo_store) { PhotoStore.make! :folder_name => "foto-test" }
  let(:folder) {
    photo_store.connection.directories.create(:key => photo_store.folder_name)
    photo_store.folder
  }
  let(:uploader) { Foto::PhotoUploader.new(folder, photo) }

  describe "upload jpg" do
    let(:photo) { path_to_fixture "jonmagic.jpg" }

    it "uploads image using date, md5sum, and extension for path" do
      expect(uploader.upload.public_url).to \
        eq("https://foto-test.s3.amazonaws.com/2013/12/2/8079bd4fd6d99b2a9891763df1a4cda9.jpg")
    end
  end

  describe "upload png" do
    let(:photo) { path_to_fixture "jonmagic.png" }

    it "uploads image using date, md5sum, and extension for path" do
      expect(uploader.upload.public_url).to \
        eq("https://foto-test.s3.amazonaws.com/2013/12/22/2796cc91eeee95410b600ae7c12952bc.png")
    end
  end

  describe "upload png" do
    let(:photo) { path_to_fixture "johndbritton.tiff" }

    it "uploads image using date, md5sum, and extension for path" do
      expect(uploader.upload.public_url).to \
        eq("https://foto-test.s3.amazonaws.com/2013/8/24/b2816cd510693da11786a9a8827d9254.tiff")
    end
  end
end