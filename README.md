# cse3120-contest1

To compile: move the `Connect4.asm` file into Visual Studio and go to Build > Build Solution. Then, you can Run and Debug the project.

To run: move `Connect4.asm` into Visual Studio, and click Debug > Start Debugging. The code is organized into blocks within a single file, which optimizes user experience simplifying setup. No other additional setup is needed. To play, there are seven column numbers, and you can play a column by entering the correct column number. Various checks are in place to ensure your input is valid. You are "Player A", and you play against an AI opponent who is "Player B". The objective of the game is to drop your pieces in such a way that four of them are in a row. The AI is of easy difficulty and will also attempt to connect 4 in a row, albeit with random moves.

You are encouraged to use the above compilation process, but an example of using `ml.exe` and the linker is added in `backup_compile.bat` if additional compilation scripts are needed. If you choose this method, you must modify the path to where you saved `Connect4.asm` and modify the example paths to include your correct project and username by replacing `{your-username}`.