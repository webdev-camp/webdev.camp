feature 'Applies' do

  before(:each) do
    sign_new
    create_list( :course  , 3)
    visit application_path
  end
  after(:each) do
    Warden.test_reset!
  end

  scenario 'Send Application' do
    within "#apply_primary_choice_course_id" do
      courses = page.find_all("option")
      expect(courses.length).to be 2
    end
  end

  scenario "has plan select" do
    within "#apply_plan" do
      courses = page.find_all("option")
      expect(courses.length).to be 3
    end

  end
end
