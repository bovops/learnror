require 'rails_helper'

describe Answer do
  it { should validate_presence_of :body }
  it { should validate_presence_of :user }
  it { should validate_presence_of :question }
  it { should belong_to :question }
  it { should belong_to :user }
  it { should have_many :comments }
  it { should have_many :attachments }

  describe '#accept' do
    let!(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }

    context 'question has not accepted answer' do
      it 'set accept flag to answer' do
        answer.accept
        expect(answer.reload).to be_accepted
      end
    end

    context 'question already has accepted answer' do
      let!(:old_answer) { create(:answer, question: question, user: user, accepted: true) }

      it 'removes accepted flag from other answers' do
        answer.accept
        expect(old_answer.reload).to_not be_accepted
      end

      it 'set accept flag to answer' do
        answer.accept
        expect(answer.reload).to be_accepted
      end
    end

    context 'answer already accepted' do
      let(:answer) { create(:answer, question: question, user: user, accepted: true) }

      it 'does not reset flag' do
        answer.accept
        expect(answer.reload).to be_accepted
      end
    end

  end

end
