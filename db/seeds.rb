# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tag.create([
    {name: '悲しい',genre:'感情'},
    {name: '嬉しい',genre:'感情'},
    {name: '面白い',genre:'感情'},
    {name: 'きゅんとした',genre:'感情'},
    {name: '感動した',genre:'感情'},
    {name: '夕暮れ',genre:'シーン'},
    {name: '夜中の散歩',genre:'シーン'},
    {name: '失恋',genre:'シーン'},
    {name: '朝',genre:'シーン'}
])