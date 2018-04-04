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
  end

  def update
    @ruby_x_axis += @velocity_x
    @ruby_y_axis += @velocity_y
    @velocity_x *= -1 if @ruby_x_axis + @width / 2 > 800 || @ruby_x_axis - @width / 2 < 0
    @velocity_y *= -1 if @ruby_y_axis + @height / 2 > 600 || @ruby_y_axis - @height /2 < 0
    @visible -= 1
    @visible = 30 if @visible < -10 && rand < 0.01
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
  end

  def button_down(id)
    if (id == Gosu::MsLeft)
      if Gosu.distance(mouse_x, mouse_y, @ruby_x_axis, @ruby_y_axis) < 50 && @visible >= 0
        @hit = 1
      else
        @hit = -1
      end
    end
  end
end

window = WhackARuby.new
window.show