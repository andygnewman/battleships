require 'board'

describe Board do

  let(:board) {Board.new}
  
  context 'a grid when initialised should' do
  
    it 'have 100 cells' do
      expect(board.grid.length).to eq(100)
    end

  end

  context 'placing ships' do

    it 'should accept a ship placement instruction (of size 1)' do # how do we do a double gere?
      grid_ref = board.grid[:A1]
      board.place_ship_unit(grid_ref)
      expect(grid_ref.content).to eq(:ship)
    end

    it 'should know which cells to place a ship in' do
      board.footprint(3, :v, :A1)
      expect(board.footprint_array).to eq([:A1, :A2, :A3])
    end

    it 'should return an error if footprint goes outside the grid' do

      expect{board.footprint(4, :h, :I6)}.to raise_error(RuntimeError, 'Cannot place, ship goes outside grid')
    end

    it 'should know the content of all cells in the footprint' do
      board.check_footprint_content([:A1, :A2, :A3])
      expect(board.footprint_content).to eq([:water, :water, :water])
    end

    it 'should return true if the footprint is clear of ships' do
      expect(board.footprint_unoccupied([:water, :water, :water])).to be true
    end

    it 'should return false if the footprint is not clear of ships' do
      expect(board.footprint_unoccupied([:water, :ship, :water])).to be false
    end

    it 'should be able to place a ship in it\'s footprint' do
      board.footprint(3, :v, :A1)
      board.footprint_array.each { |cell| board.grid[cell].ship_in_cell! }
      board.check_footprint_content(board.footprint_array)
      expect(board.footprint_content.all? {|content| content == :ship}).to eq(true)
    end

  end

end

# doubles to isolate item being tested