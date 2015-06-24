# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.destroy_all
Wiki.destroy_all

admin = User.create(
                    name: "admin",
                    email: "admin@mail.com",
                    password: "administrator",
                    role: "admin"
                    )


for i in 1..3
  User.create(
              name: "premium#{i}",
              email: "premium#{i}@mail.com",
              password: "premium#{i}",
              role: "premium"
              )
end

for i in 1..3
  User.create(
           name: "standard#{i}",
           email: "standard#{i}@mail.com",
           password: "standard#{i}",
           role: "standard"
           )
end
