# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

partner1 = Partner.create 	:first_name => 'Jason',
							:last_name => 'Lizarraga',
							:employee_no => '789654321',
							:is_manager => true,
							:is_temp => false
partner2 = Partner.create 	:first_name => 'Chris',
							:last_name => 'Gungaloo',
							:employee_no => '123456789',
							:is_manager => true,
							:is_temp => false
partner3 = Partner.create 	:first_name => 'Nicola',
							:last_name => 'Santen',
							:employee_no => '741852963',
							:is_manager => false,
							:is_temp => false
partner4 = Partner.create 	:first_name => 'John',
							:last_name => 'Lewis',
							:employee_no => '369258147',
							:is_manager => false,
							:is_temp => true

partner1.contact.create		:telephone_no  => '07944055452'
							:address_line1 => '1542 New Avenue'
							:address_line2 => ''
							:city          => 'Dagenham'
							:county        => 'Essex'
							:post_code     => 'RM12 3FR'

partner2.contact.create		:telephone_no  => '07960577214'
							:address_line1 => '255 Morland Street'
							:address_line2 => 'Croydon'
							:city          => 'London'
							:county        => ''
							:post_code     => 'CR0 3DE'

partner3.contact.create		:telephone_no  => '02085412244'
							:address_line1 => '1 Brocket Avenue'
							:address_line2 => ''
							:city          => 'Chigwell'
							:county        => 'Essex'
							:post_code     => 'IG4 5JE'

partner4.contact.create		:telephone_no  => '02074125465'
							:address_line1 => 'Flat B'
							:address_line2 => '245 Commercial Road'
							:city          => 'London'
							:county        => ''
							:post_code     => 'E3 5GH'

partner1.work_plan.create({:starting_week_no => '1', :holiday_entitle => '25', :holiday_taken => '5'})
partner1.work_plan.weekly_rotas.create()						
partner1.work_plan.weekly_rotas[0].shift_template.create([	{:name =>partner1.first_name + partner1.last_name, :start_at => DateTime.parse("Sun, 1 Jan 2006 10:00:00 +0000"), :end_at => DateTime.parse("Sun, 1 Jan 2006 18:00:00 +0000")},
															{:name =>partner1.first_name + partner1.last_name, :start_at => DateTime.parse("Mon, 2 Jan 2006 9:00:00 +0000"), :end_at => DateTime.parse("Mon, 2 Jan 2006 17:00:00 +0000")},
															{:name =>partner1.first_name + partner1.last_name, :start_at => DateTime.parse("Tue, 3 Jan 2006 10:00:00 +0000"), :end_at => DateTime.parse("Tue, 3 Jan 2006 18:00:00 +0000")},
															{:name =>partner1.first_name + partner1.last_name, :start_at => DateTime.parse("Wed, 4 Jan 2006 9:00:00 +0000"), :end_at => DateTime.parse("Wed, 4 Jan 2006 17:00:00 +0000")},
															{:name =>partner1.first_name + partner1.last_name, :start_at => DateTime.parse("Thu, 5 Jan 2006 10:00:00 +0000"), :end_at => DateTime.parse("Thu, 5 Jan 2006 18:00:00 +0000")}
															])
partner1.work_plan.holidays.create([	{:name =>partner1.first_name + partner1.last_name, :start_at => DateTime.parse("23 Jan 2011 10:00:00 +0000"), :end_at => DateTime.parse("23 Jan 2011 18:00:00 +0000")},
										{:name =>partner1.first_name + partner1.last_name, :start_at => DateTime.parse("24 Jan 2011 9:00:00 +0000"), :end_at => DateTime.parse("24 Jan 2011 17:00:00 +0000")},
										{:name =>partner1.first_name + partner1.last_name, :start_at => DateTime.parse("25 Jan 2011 10:00:00 +0000"), :end_at => DateTime.parse("25 Jan 2011 18:00:00 +0000")},
										{:name =>partner1.first_name + partner1.last_name, :start_at => DateTime.parse("26 Jan 2011 9:00:00 +0000"), :end_at => DateTime.parse("26 Jan 2011 17:00:00 +0000")},
										{:name =>partner1.first_name + partner1.last_name, :start_at => DateTime.parse("27 Jan 2011 10:00:00 +0000"), :end_at => DateTime.parse("27 Jan 2011 18:00:00 +0000")},
										])
