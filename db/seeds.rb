# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless Task.exists?
  Task.create(title: 'first_task', content: 'manger' , deadline_on: '2025-02-18', priority: 'Moyenne', status: 'Non_démarré')
  Task.create(title: 'second_task', content: 'dormir' , deadline_on: '2025-02-17', priority: 'Elevee', status: 'Démarré')
  Task.create(title: 'third_task', content: 'prier' , deadline_on: '2025-02-16', priority: 'Faible', status: 'Terminé')
  Task.create(title: 'fourth_task', content: 'nager' , deadline_on: '2025-02-18', priority: 'Moyenne', status: 'Non_démarré')
  Task.create(title: 'fifth_task', content: 'marcher' , deadline_on: '2025-02-17', priority: 'Elevee', status: 'Démarré')
  Task.create(title: 'sixth_task', content: 'chatter' , deadline_on: '2025-02-16', priority: 'Faible', status: 'Terminé')
  Task.create(title: 'seventh_task', content: 'aller faire du sport' , deadline_on: '2025-02-18', priority: 'Moyenne', status: 'Non_démarré')
  Task.create(title: 'eighth_task', content: 'cuisiner' , deadline_on: '2025-02-17', priority: 'Elevee', status: 'Démarré')
  Task.create(title: 'nineth_task', content: 'sortir' , deadline_on: '2025-02-16', priority: 'Faible', status: 'Terminé')
  Task.create(title: 'tenth_task', content: 'regarder' , deadline_on: '2025-02-18', priority: 'Moyenne', status: 'Non_démarré')  
end