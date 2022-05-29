class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    record.alpaca.owner != user
  end

  def accept?
    record.owner == user
  end

  def reject?
    record.owner == user
  end
end
