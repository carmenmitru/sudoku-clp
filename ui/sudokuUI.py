from tkinter import Tk, Canvas, Frame, Button, BOTH, TOP, BOTTOM, RIGHT,LEFT
import clips
import os
import string
import math


MARGIN = 20  # Pixels around the board
SIDE = 50  # Width of every board cell.
WIDTH = HEIGHT = MARGIN * 2 + SIDE * 9  # Width and height of the whole board


class SudokuUI(Frame):
  
    def __init__(self, parent, game):
        self.game = game
        Frame.__init__(self, parent)
        self.parent = parent

        self.row, self.col = -1, -1
        self.__read_solution()
        self.__initUI()

    def __read_solution(self):
        filepath = 'fiesire.dat'
        self.solution = []
        with open(filepath) as fp:
            line = fp.readline()
            cnt = 1
            while line:
                # print("Line {}: {}".format(cnt, line.strip()))
                self.solution.append(line.strip())
                line = fp.readline()
                cnt += 1

    def __initUI(self):
        self.parent.title("Sudoku SBC Pr")
        self.pack(fill=BOTH)
        self.canvas = Canvas(self,
                             width=WIDTH,
                             height=HEIGHT)
        self.canvas.pack(fill=BOTH, side=TOP)
        solve_button = Button(self, text="Solve Sudoku", height = 5, width = 20,
                              command=self.__solve_puzzle)
        solve_button.pack(fill=BOTH, side=BOTTOM)

        self.__draw_grid()
        self.__draw_puzzle()

        self.canvas.bind("<Button-1>", self.__cell_clicked)

    def __draw_grid(self):
        """
        Draws grid divided with blue lines into 3x3 squares
        """
        for i in range(10):
            color = "blue" if i % 3 == 0 else "gray"

            x0 = MARGIN + i * SIDE
            y0 = MARGIN
            x1 = MARGIN + i * SIDE
            y1 = HEIGHT - MARGIN
            self.canvas.create_line(x0, y0, x1, y1, fill=color)

            x0 = MARGIN
            y0 = MARGIN + i * SIDE
            x1 = WIDTH - MARGIN
            y1 = MARGIN + i * SIDE
            self.canvas.create_line(x0, y0, x1, y1, fill=color)

    def __draw_puzzle(self):
        
        for i in range(9):
            for j in range(9):
                x = MARGIN + j * SIDE + SIDE / 2
                y = MARGIN + i * SIDE + SIDE / 2
                color = "black"
                if self.game.start_puzzle[i][j] == "*":
                    self.canvas.create_text(
                        x, y, text="", tags="numbers", fill=color
                    )
                else:
                    self.canvas.create_text(
                        x, y, text=self.game.start_puzzle[i][j], tags="numbers", fill=color
                    )

    def __solve_puzzle(self):
        print("__solve_puzzle__click Btn")

        self.__fill_solution()

    def __extract_values(self, s):
        rowSol = s.split('-')[0]
        columnSol = s.split('-')[1].split(" ")[0]
        nrSol = s.split(" ")[1]

        return (rowSol, columnSol, nrSol)

    def __get_position_in_matrix(self, rowSol, columnSol):
        # F - 8 means row 5 column 7
        # string.ascii_lowercase.index('f') = 5 get the index of the letter in alphabet
        row = int(string.ascii_lowercase.index(rowSol.lower()))
        col = int(columnSol) - 1
        return (row, col)

    def __get__cordinates_in_grid(self, row, col):
        x = MARGIN + col * SIDE + SIDE / 2
        y = MARGIN + row * SIDE + SIDE / 2
        return (x, y)

    def __fill_solution(self):
        ''' 
        F-8 2 
        1.Get the solution and split it by space
        # First character is the row  
        # Second character is the column
        # Third character is the solution
        # 2. Using the row and the column get the cell
        # Fill the cell with the value 
        '''



        for s in self.solution:
            (rowSol, columnSol, nr) = self.__extract_values(s)

            (row, col) = self.__get_position_in_matrix(rowSol, columnSol)

            (x, y) = self.__get__cordinates_in_grid(row, col)
            color = "red"

            self.canvas.create_text(
                x, y, text=nr, tags="numbers", fill=color
            )

    def __cell_clicked(self, event):
       
        x, y = event.x, event.y
        if (MARGIN < x < WIDTH - MARGIN and MARGIN < y < HEIGHT - MARGIN):
            self.canvas.focus_set()

            # get row and col numbers from x,y coordinates
            rowClick, colClick = (y - MARGIN) / SIDE, (x - MARGIN) / SIDE
            print("RowClick {} colClick {} ".format(rowClick,colClick))
            x = MARGIN + math.floor(colClick) * SIDE + SIDE / 2
            y = MARGIN + math.floor(rowClick) * SIDE + SIDE / 2
            color = "green"

            for s in self.solution:
                (rowSol, columnSol, nr) = self.__extract_values(s)

                (row, col) = self.__get_position_in_matrix(rowSol, columnSol)

                if math.floor(rowClick) == row and math.floor(colClick) == col:
                    self.canvas.create_text(
                        x, y, text=nr, tags="numbers", fill=color
                    )
        else:
            self.row, self.col = -1, -1

