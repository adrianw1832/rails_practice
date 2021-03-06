module AsUserAssociationExtensions
  def created_by?(user)
    self.user == user
  end

  def destroy_as_user(user)
    destroy if created_by?(user)
  end
end
