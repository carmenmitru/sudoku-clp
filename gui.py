#!/usr/bin/python
import os



from tkinter import Tk
from ui import SudokuUI
from ui import SudokuBoard


# Clips Integration
# from clipspy import clips
# from clipspy.clips import Environment, Symbol
import clips


MARGIN = 20  # Pixels around the board
SIDE = 50  # Width of every board cell.
WIDTH = HEIGHT = MARGIN * 2 + SIDE * 9  # Width and height of the whole board


class SudokuGame(object):


    def __init__(self, board_file):
        """ 
        Step 1. Load the clp file
        Step 2. Save the board in a variable
        Step 3. Create puzzle
        """
        self.__load_clp()
        self.board_file = board_file
        self.start_puzzle = SudokuBoard(board_file).board

    def __load_clp(self):
        try:
           os.remove("fiesire.dat")
        except OSError:
            pass
        
        env = clips.Environment()
        env.load("sudokuv3.clp")

        env.reset()
        env.run()



if __name__ == '__main__':
    

    with open('puzzle.in', 'r') as boards_file:
        print(boards_file)
        game = SudokuGame(boards_file)



        root = Tk()
        SudokuUI(root, game)
        root.geometry("%dx%d" % (WIDTH, HEIGHT + 40))
        root.mainloop()