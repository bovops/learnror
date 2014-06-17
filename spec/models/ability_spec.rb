require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  context 'when guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  context 'when admin' do
    let(:user) { create(:user, admin: true) }

    it { should be_able_to :manage, :all }

  end

  context 'when user' do
    let!(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let!(:other_question) { create(:question, user: other_user) }
    let(:answer) { create(:answer, question: question, user: user) }
    let(:other_answer) { create(:answer, question: question, user: other_user) }
    let(:other_user) { create(:user) }
    let(:comment) { create(:comment, commentable: question, user: user) }
    let(:other_comment) { create(:comment, commentable: question, user: other_user) }

    it { should be_able_to :read, :all }
    it { should_not be_able_to :manage, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, user, id: user.id }
    it { should_not be_able_to :update, other_user, id: user.id }

    it { should be_able_to :update, question, user_id: user.id }
    it { should_not be_able_to :update, other_question, user_id: user.id }

    it { should be_able_to :update, answer, user_id: user.id }
    it { should_not be_able_to :update, other_answer, user_id: user.id }

    it { should be_able_to :update, answer, user_id: user.id }
    it { should_not be_able_to :update, other_answer, user_id: user.id }

    it { should be_able_to :update, comment, user_id: user.id }
    it { should_not be_able_to :update, other_comment, user_id: user.id }

    it { should be_able_to :destroy, user, id: user.id }
    it { should_not be_able_to :destroy, other_user, id: user.id }

    it { should be_able_to :destroy, question, user_id: user.id }
    it { should_not be_able_to :destroy, other_question, user_id: user.id }

    it { should be_able_to :destroy, answer, user_id: user.id }
    it { should_not be_able_to :destroy, other_answer, user_id: user.id }

    it { should be_able_to :destroy, answer, user_id: user.id }
    it { should_not be_able_to :destroy, other_answer, user_id: user.id }

    it { should be_able_to :destroy, comment, user_id: user.id }
    it { should_not be_able_to :destroy, other_comment, user_id: user.id }

  end
end