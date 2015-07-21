class QuizAnswerRequest
  include ActiveModel::Model
  attr_accessor :task_id, :answer, :token
  attr_reader :task, :user

  validates :task_id, :token, :answer, presence: true
  validate :user_existence, :task_existence, :task_still_availible, :task_matches_user_level

  def user_existence
    unless user.present?
      self.errors.add(:user, 'does not exist')
    end
  end

  def task_existence
    unless task.present?
      self.errors.add(:task, 'does not exist')
    end
  end

  def task_still_availible
    if task.present?
      self.errors.add(:task, 'is expired') if task.answered?
      if task.created_at.nil? || task.created_at < 5.minutes.ago
        self.errors.add(:task, 'is outdated')
      end
    end
  end

  def task_matches_user_level
    if task.present? && user.present?
      self.errors.add(:task, 'level mismatch') if task.level != user.level
    end
  end

  def task
    @task ||= Task.find_by(id: self.task_id)
  end

  def user
    @user ||= User.find_by(token: self.token)
  end

end
