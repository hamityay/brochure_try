class Picture < ActiveRecord::Base
  belongs_to :brochure

  has_attached_file :picture,
                    styles: {
                      brochure_style: '717x1014>', scaled: '70%', preview: '495x330>', list: '174x245>',
                      medium: '300x300>', small: '150x150>', thumb: '100x100>', deneme: '10x10'
                    },
                    convert_options: {
                      brochure_style: '-gravity center -background white -extent 717x1014',
                      preview: '-gravity center -background white -extent 495x330',
                      list: '-gravity center -background white -extent 174x245',
                      medium: '-gravity center -background white -extent 300x300',
                      small: '-gravity center -background white -extent 150x150',
                      thumb: '-gravity center -background white -extent 100x100',
                      deneme: '-gravity center -background white -extent 10x10'
                    },
                    default_url: '/images/missing_cover.png'
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
