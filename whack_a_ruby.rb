require 'gosu'

class WhackARuby < Gosu::Window
  def initialize()
    super(800, 600)
    self.caption = "Whack the Ruby!"
    @ruby = Gosu::Image.new('ruby.png')
    @ruby_x_axis = 200
    @ruby_y_axis = 200
    @width = 50
    @height = 43
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
    @hammer = Gosu::Image.new('hammer.png')
    @hit = 0
    @font = Gosu::Font.new(30)
    @score = 0
    @playing = true
    @start_time = 0
  end

  def update
    if @playing
      @ruby_x_axis += @velocity_x
      @ruby_y_axis += @velocity_y
      @velocity_x *= -1 if @ruby_x_axis + @width / 2 > 800 || @ruby_x_axis - @width / 2 < 0
      @velocity_y *= -1 if @ruby_y_axis + @height / 2 > 600 || @ruby_y_axis - @height /2 < 0
      @visible -= 1
      @visible = 30 if @visible < -10 && rand < 0.01
      @time_left = (500 - ((Gosu.milliseconds - @start_time) / 100))
      @playing = false if @time_left < 0
    end
  end

  def draw()
    if @visible > 0
      @ruby.draw(@ruby_x_axis - @width / 2, @ruby_y_axis - @height / 2, 1)
    end
    @hammer.draw(mouse_x - 30, mouse_y - 30, 1)
    if @hit == 0
      c = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end
    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
    @hit = 0
    @font.draw(@score.to_s, 700, 20, 2)
    @font.draw(@time_left.to_s, 20, 20, 2)
    unless @playing
      @font.draw('Game Over', 300, 300, 3)
      @font.draw('Press the spacebar to play again', 175, 350, 3)
      @visible = 20
    end
  end

  def button_down(id)
    if @playing
      if (id == Gosu::MsLeft)
        if Gosu.distance(mouse_x, mouse_y, @ruby_x_axis, @ruby_y_axis) < 50 && @visible >= 0
          @hit = 1
          @score += 5
        else
          @hit = -1
          @score -= 1
        end
      end
    else
      if (id == Gosu::KbSpace)
        @playing = true
        @visible = -10
        @start_time = Gosu.milliseconds
        @score = 0
      end
    end
  end
end

window = WhackARuby.new
window.show