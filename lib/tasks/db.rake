# frozen_string_literal: true

namespace :db do
  desc 'Empty and fill with example data for development'
  task sampledata: :environment do
    Rake::Task['db:reset'].invoke

    # Create event data
    event = Event.create(
      event_code: 'GS2019',
      event_year: 2019,
      event_location: 'Red Lion',
      set: true
    )

    event.save!

    # Create paw staff list

    5.times do |s|
      staff = PawStaff.create(
        badge: 100 + s,
        name: "Name #{s}",
        title: "Title #{s}",
        phone: "555-555-555#{s}",
        email: "test#{s}@test.test",
        role: "Role #{s}"
      )

      staff.save!
    end

    # Create inventory list

    20.times do |i|
      game = Inventory.create(
        title: "Title#{i}",
        company: "Company#{i}",
        quantity_total: 1
      )

      game.save!
    end

    # Create sample participants

    5.times do |p|
      member = Participant.create(
        badge: 200 + p,
        name: "Member #{p}",
        phone: "555-555-555#{p}",
        email: "test#{p}@test.test",
        pref: %w[Call Text Email].sample,
        proxy: [true, false].sample,
        p_badge: nil,
        p_name: nil,
        p_phone: nil,
        p_email: nil,
        p_pref: nil
      )
      if member[:proxy] == true
        member[:p_badge] = 300 + p
        member[:p_name] = "Proxy #{p}"
        member[:p_phone] = '555-555-5555'
        member[:p_email] = "proxy#{p}@test.test"
        member[:p_pref] = %w[Call Text Email].sample
      end

      member.save!
    end

    # Create sample schedule

    10.times do |sh|
      randomdate = Random.rand(1..30)
      randomtime = Random.rand(1..21)
      startTime = Time.new(2019, 6, randomdate, randomtime)
      endTime = startTime + 1800
      randomlocation = ('a'..'z').to_a.sample

      schedule = Schedule.create(
        start: startTime,
        end: endTime,
        location: "#{randomlocation}#{sh}",
        inventory_id: Random.rand(1..20),
        paw_staff_id: Random.rand(1..5),
        event_id: 1
      )

      schedule.save!
    end

    # Create library logs
    Inventory.all.length.times do |i|
      i += 1

      library_log = Library.create(
        inventory_id: i,
        participant_id: 1,
        event_id: 1,
        checked_in: Time.now,
        quantity_left: Inventory.find(i)[:quantity_total]
      )

      library_log.save!
    end

    # Add sample users

    admin = User.create(
      username: 'admin',
      password: 'admin'
    )

    admin.save!

    staff = User.create(
      username: 'staff',
      password: 'staff'
    )

    staff.save!
  end
end
