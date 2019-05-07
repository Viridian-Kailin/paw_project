# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

import_games = YAML.load(File.read('db/2019_seeds/inventories.yml'))
import_games.each {|x| Inventory.where(x).first_or_create(x)}

import_gms = YAML.load(File.read('db/2019_seeds/gm_list.yml'))
import_gms.each {|x| Participant.where(x).first_or_create(x)}

import_staff = YAML.load(File.read('db/2019_seeds/gm_list.yml'))
import_gms.each {|x| PawStaff.where(x).first_or_create(x)}

import_events = YAML.load(File.read('db/2019_seeds/event.yml'))
import_events.each {|x| Event.where(x).first_or_create(x)}

import_schedule = YAML.load(File.read('db/2019_seeds/schedule.yml'))
import_schedule.each {|x| Schedule.where(x).first_or_create(x)}

import_library = YAML.load(File.read('db/2019_seeds/library_log.yml'))
import_library.each {|x| Library.where(x).first_or_create(x)}
