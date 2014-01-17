class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  has_ancestry orphan_strategy: :destroy

  alias_attribute :author, :user

  def content
    deleted? ? :deleted : body
  end

  def undelete
    self.deleted_at = nil
  end

  def delete
    self.deleted_at = Time.now
  end

  def deleted?
    !deleted_at.nil?
  end

  def descriptor
    OpenSSL::Digest::SHA256.hexdigest([id,body,created_at].join('-'))
  end
end
