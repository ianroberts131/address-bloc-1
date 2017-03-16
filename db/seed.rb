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
