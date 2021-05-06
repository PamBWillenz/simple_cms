class Page < ApplicationRecord

  belongs_to :subject
  has_many :page_assignments
  has_many :users, :through => :page_assignments

  scope :visible, lambda { where(visible: true) }
  scope :invisible, lambda { where(visible: false) }
  scope :sorted, lambda { order(:position) }

  before_validation :titleize_name
  validates :name, :presence => true, :length => {:maximum => 50}
  validates :position, 
    :presence => true,
    :numericality => {:greater_than =>0}

  validates :permalink,
    :presence => true,
    :length => {:maximum => 50},
    :uniqueness => true, 
    :format => { :with => /\A\w+\Z/ }

  private

  def titleize_name
    self.name = name.titleize
  end
end
