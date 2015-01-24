class Post < ActiveRecord::Base
  belongs_to :usuario, dependent: :destroy
  has_many :attachments
  validates :titulo, presence: true, uniqueness: true
  before_save :valores_por_default
	include Picturable
	include PublicActivity::Model
	tracked owner: Proc.new{ |controller, model| controller.current_usuario }

	def valores_por_default
		self.costo ||= 0		
	end
end
