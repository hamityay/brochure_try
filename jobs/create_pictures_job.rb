class CreateBrochurePicturesJob < ActiveJob::Base
  queue_as :high_priority

  def perform(brochure_id)
    brochure = Brochure.find brochure_id
    pdf_file_path = brochure.file.path
    a = brochure.file.path.split '/'
    pic_path = "/"+a[1]+"/"+a[2]+"/"+a[3]+"/"+a[4]+"/"+a[5]+"/"+a[6]+"/"+a[7]+"/"+a[8]+"/"+a[9]+"/"+a[10]+"/"+a[11]
    brochure_dir = "#{Rails.root}/tmp/brochures"
    brochure_files_dir = "#{brochure_dir}/#{brochure.id}"
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