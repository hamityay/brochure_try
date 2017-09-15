class Brochure < ActiveRecord::Base

  has_many :pictures, dependent: :destroy

  has_attached_file :file
  validates_attachment :file, content_type: { content_type: 'application/pdf', message: I18n.t('activerecord.errors.models.brochure.attributes.file.invalid') }

  after_commit :create_pictures, on: :create

  private
    def create_pictures
      pdf_file_path = self.file.path
      a = self.file.path.split '/'
      pic_path = "/"+a[1]+"/"+a[2]+"/"+a[3]+"/"+a[4]+"/"+a[5]+"/"+a[6]+"/"+a[7]+"/"+a[8]+"/"+a[9]+"/"+a[10]+"/"+a[11]
      brochure_dir = "#{Rails.root}/tmp/brochures"
      brochure_files_dir = "#{brochure_dir}/#{self.id}"
      # pdf_file_path = "#{brochure_files_dir}/#{self.id}.pdf"
      # picture_file_path = "#{brochure_files_dir}/#{index}.jpg"
      pdf = Grim.reap(pdf_file_path)
      pdf.each_with_index do |grim_page_img, index|
        #picture_file_path = "#{brochure_files_dir}/#{brochure.title.parameterize}-#{index}.png"
        picture_file_path = "#{pic_path}/#{index}.jpg"
        # result = create_picture(index, pdf, picture_file_path)
        pdf[index].save(picture_file_path, {
          width: 1024, # defaults to 1024
          density: 200, # defaults to 300
          quality: 90, # defaults to 90
          colorspace: 'RGB', # defaults to "RGB"
          alpha: 'Remove', # not used when not set
          antialias: 'render',
          interlace: 'none'
        })
        self.pictures.create!(picture: File.new(picture_file_path), order_number: index, content: pdf[index].text)
      end
    end
end
