import os
import time
from tkinter import *
from tkinter import ttk
from functools import partial
import pygubu


class ProvaApp:
    PROJECT_PATH = os.path.dirname(__file__)
    PROJECT_UI = os.path.join(PROJECT_PATH, "prova.ui")

    def setToHole(self, target: int):
        hole = PhotoImage(file="Hole.png")
        print(target)
        self.buttons[target].config(image=self.image)
        # self.buttons[target].update()

    def prova(self):
        self.buttons[2].config(image=self.image)

    def __init__(self, rows: int, columns: int, rowConstraints: list, columnContraints: list):
        rows += 1  # Riga dei vincoli
        columns += 1  # Colonna dei vincoli
        self.builder = builder = pygubu.Builder()
        builder.add_resource_path(self.PROJECT_PATH)
        builder.add_from_file(self.PROJECT_UI)
        self.mainwindow = builder.get_object('mainwindow')
        self.mainFrame = builder.get_object('mainframe')
        self.mainFrame.grid(column=columns, row=rows)
        self.buttons = []
        self.labels = []
        self.image = PhotoImage(file="Hole.png")

        for i in range(1, rows):
            for j in range(1, columns):
                actualButton = ttk.Button(self.mainFrame)
                actualButton.config(command=partial(self.setToHole, ((i - 1) * (rows - 1)) + (j - 1)))
                actualButton.grid(row=i, column=j, sticky=(N, W))
                self.buttons.append(actualButton)
        for i in range(len(rowConstraints)):
            actualLabel = ttk.Label(self.mainFrame, text=rowConstraints[i]).grid(row=0, column=i + 1)
            self.labels.append(actualLabel)
            actualLabel = ttk.Label(self.mainFrame, text=columnContraints[i]).grid(row=i + 1, column=0)
            self.labels.append(actualLabel)
        b = ttk.Button(self.mainFrame, command=partial(self.prova)).grid(row=0, column=0)
        # self.mainFrame.update()
        builder.connect_callbacks(self)

    def run(self):
        self.mainwindow.mainloop()


if __name__ == '__main__':
    app = ProvaApp(4, 4, [1, 2, 3, 4], [1, 2, 4, 4])
    app.run()
