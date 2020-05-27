class SudokuError(Exception):
    """
    An application specific error.
    """
    pass
class SudokuBoard(object):
    def __init__(self, board_file):
        self.board = self.__create_board(board_file)

    def __create_board(self, board_file):

        # Pas1: Delete endline and spaces => 9 elements = each line of sudoku
        board = [line.rstrip('\n').replace(' ', '') for line in board_file]
        board = [element for element in board if len(element.strip()) > 0]
        # print("========BOARD=====")
        print(board)
        # print("========BOARD=====")
        for line in board:
            if len(line) != 9:
                raise SudokuError(
                    "Each line in the sudoku puzzle must be 9 chars long."
                )
       
        for c in line:
            if not (c.isdigit() or c == '*'):
                raise SudokuError(
                        "Valid characters for a sudoku puzzle must be in 0-9 or * for blank"
                    )

        if len(board) != 9:
             raise SudokuError("Each sudoku puzzle must be 9 lines long")
        return board
