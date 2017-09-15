class Brochure < ActiveRecord::Base

  has_many :pictures, dependent: :destroy

  has_attached_file :file
  validates_attachment :file, content_type: { content_type: 'application/pdf', message: I18n.t('activerecord.errors.models.brochure.attributes.file.invalid') }

  # after_commit :create_pictures, on: :create

  private

  def create_pictures
    CreateBrochurePicturesJob.set(wait: 3.seconds).perform_later(id)
  end
end
