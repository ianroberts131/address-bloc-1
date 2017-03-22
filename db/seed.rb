require_relative '../models/address_book'
require_relative '../models/entry'
require 'bloc_record'

BlocRecord.connect_to('db/address_bloc.sqlite')

book = AddressBook.create(name: "My Address Book")

puts 'Address Book created'
puts 'Entry created'

puts Entry.create(address_book_id: book.id, name: 'Foo One', phone_number: '999-999-9999', email: 'foo_one@gmail.com')
puts Entry.create(address_book_id: book.id, name: 'Foo Two', phone_number: '111-111-1111', email: 'foo_two@gmail.com')
puts Entry.create(address_book_id: book.id, name: 'Foo Three', phone_number: '222-222-2222', email: 'foo_three@gmail.com')

puts "Using find_by: #{Entry.find_by(:name, "Foo One")}"
puts "Using find_by_name: #{Entry.find_by_name("Foo One")}"

puts "Test find_each: "
puts "#{Entry.find_each(start: 2, batch_size: 2) { |entry| puts "Name: #{entry.name}" }}"

puts "Test find_in_batches: "
puts "#{Entry.find_in_batches(start: 1, batch_size: 2) { |entries| entries.each { |entry| puts "Name: #{entry.name}" } } }"

puts "Test order: "
puts "#{Entry.order(name: :asc, phone_number: :desc)}"

puts "Test where: "
puts "#{Entry.where(address_book_id: 1)}"

puts "Test update: "
people = { 1 => {"name" => "Norris"}, 2 => {"name" => "Irang"} }
Entry.update(people.keys, people.values)
puts "#{Entry.all}"

puts "Test method missing: "
entry = Entry.find_one(3)
entry.update_name("Amadeus")
puts "#{Entry.all}"

puts "Test where/take chain: "
entry = Entry.where("name": "Amadeus").take(1)
puts "#{entry}"

puts "Test where/where chain: "
entry = Entry.where("name": "Amadeus").where(email: "foo_three@gmail.com")
puts "#{entry}"

puts "Test where.not chain: "
entries = Entry.where.not("name" => "Amadeus")
puts "#{entries.inspect}"

# puts "Test #destroy_all with string input: "
# puts "List of all entries: "
# puts "#{Entry.all}"
# puts "Destroying Amadeus..."
# Entry.destroy_all("name = 'Amadeus'")
# puts "List of all entries: "
# puts "#{Entry.all}"

# puts "Test #destroy_all on an array: "
# puts "List of all entries: "
# puts "#{Entry.all}"
# puts "Entry.where(name: Norris).destroy_all..."
# Entry.where(name: 'Norris').destroy_all
# puts "Now the list of all entries is:"
# puts "#{Entry.all}"

# puts "Test #destroy_all with array conditions: "
# puts "List of all entries: "
# puts "#{Entry.all}"
# puts "Entry.destroy_all('phone_number = ?', '111-111-1111')"
# Entry.destroy_all("phone_number = ?", '111-111-1111')
# puts "Now the list of all entries is:"
# puts "#{Entry.all}"
