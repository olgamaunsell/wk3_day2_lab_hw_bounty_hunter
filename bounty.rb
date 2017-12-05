require('pg')


class Bounty

  attr_accessor :name, :species, :bounty_value, :fav_weapon

  attr_reader :id

  def initialize (options)

    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i
    @fav_weapon = options['fav_weapon']
  end


  def save()

    db = PG.connect({dbname: 'bounty', host:'localhost'})

    sql =
    "INSERT INTO bounty
    ( name,
      species,
      bounty_value,
      fav_weapon)
      VALUES
      ($1,$2,$3,$4)
      RETURNING *
      "

      values=[@name, @species,@bounty_value, @fav_weapon]
      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]['id'].to_i

      db.close()

    end

    def self.all()

      db = PG.connect({dbname: 'bounty', host:'localhost'})
      sql = "SELECT * FROM bounty"
      db.prepare("all", sql)

      hunters = db.exec_prepared("all")
      db.close()

      return hunters.map {|hunter| Bounty.new(hunter)}
    end

    def self.delete_all()
      db = PG.connect({dbname: 'bounty', host:'localhost'})
      sql = "DELETE FROM bounty"
      db.prepare("delete_all", sql)
      db.exec_prepared("delete_all")
      db.close()
    end

    def delete()
      db = PG.connect({dbname: 'bounty', host:'localhost'})
      sql = "DELETE FROM bounty
      WHERE id = $1"
      values = [@id]
      db.prepare("delete_one", sql)
      db.exec_prepared("delete_one", values)
      db.close()
    end

    def update()
      db = PG.connect({dbname: 'bounty', host:'localhost'})
      sql = "UPDATE bounty
      SET (
        name,
        species,
        bounty_value,
        fav_weapon
        ) =
        ($1, $2, $3, $4)
        WHERE id = $5"
        values = [@name, @species, @bounty_value, @fav_weapon, @id]
        db.prepare("update", sql)
        db.exec_prepared("update", values)
        db.close()

      end

      def self.find(id)

        db = PG.connect({dbname: 'bounty', host:'localhost'})
        sql = "SELECT * FROM bounty WHERE id = $1"
        values = [id]
        db.prepare("find", sql)
        hunter = db.exec_prepared("find", values)
        db.close()

        bounty_hunter = hunter.map {|hunter| Bounty.new(hunter)}

        return bounty_hunter[0]

      end


    end
