require('pry-byebug')
require_relative('../bounty.rb')

Bounty.delete_all()

bounty1 = Bounty.new({
    'name' => 'Ross',
    'species' => 'human',
    'bounty_value' => '1',
    'fav_weapon' => 'laptop'
  })

  bounty2 = Bounty.new({
      'name' => 'Craig',
      'species' => 'wolf',
      'bounty_value' => '2',
      'fav_weapon' => 'razor'
    })

bounty1.save()
bounty2.save()

# bounty1.delete()

# bounty2.name = "Vishal"
# bounty2.update()


# hunters = Bounty.all()

hunter = Bounty.find(6)

binding.pry
nil
