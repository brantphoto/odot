require 'spec_helper'

describe "Editing todo lists" do 
	let!(:todo_list) {TodoList.create(title:"Groceries", description:"This is a grocery list")}
	def update_todo_list(options={})
		options[:title] ||= "New Title"
    options[:description] ||= "New Description"

    todo_list = options[:todo_list]

    visit "/todo_lists"

    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end


  it "updates a todo list successfully" do 

    update_todo_list todo_list: todo_list,
    									title: "New Title",
    									description: "New description"

    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated.")
    expect(todo_list.title).to eq("New Title")
	end
	
end
	

