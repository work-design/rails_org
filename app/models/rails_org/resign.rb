module RailsOrg::Resign
  extend ActiveSupport::Concern
  included do
    attribute :state, :string, default: 'init'

    validates :leave_on, :reason_note, presence: true

    belongs_to :member

    has_many :resign_references
    has_many :resign_reasons, through: :resign_references
    validate :validate_resign_reasons

    enum state: {
      init: 'init',
      approved: 'approved',
      rejected: 'rejected'
    }

    after_create_commit :send_notification

    acts_as_notify only: [:reason_note, :leave_on]
  end

  def do_trigger(params = {})
    self.trigger_to(params.slice(:state))

    self.class.transaction do
      self.save!
      to_notification(
        sender: self.member.office.leader,
        receiver: self.member,
        title: "Your resignation request has been #{self.state_i18n}.",
        body: "Your resignation request has been #{self.state_i18n}.",
        link: url_helpers.my_resign_url,
        cc_emails: [
          self.member.office.leader.email
        ],
      )
    end
  end

  def send_notification
    to_notification(
      sender: self.member,
      receiver: self.member.office.leader,
      body: "#{self.member.name} has requested resignation",
      title: "#{self.member.name} has requested resignation",
      cc_emails: [
        self.member.email
      ],
      link: url_helpers.hr_resign_url(id: self.id),
      verbose: true
    )
  end

  def validate_resign_reasons
    self.errors.add :base, 'Please select one reason at least' if self.resign_reasons.empty?
  end
end
