import os
import tkinter as tk
from tkcalendar import Calendar

class Window:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Package Installation Options")
        self.root.configure(bg='#00A5FF')  # Set background color
        self.widgets_builder()
        # Grab the saved data
        self.getdata()
        self.binding()
        self.root.mainloop()

    def widgets_builder(self):
        self.label1()
        self.entry1()
        self.listbox()
        self.label2()
        self.calendar()
        self.message_boxes()
        self.install_button()

    def label1(self):
        self.lab1 = tk.Label(
            self.root, text="Enter to add items, \nSelect to delete Items,\n ctr+s to save",
            bg='#FF00D0', anchor="w")  # Set label background color and anchor to left
        self.lab1.pack(fill="both", padx=5, pady=5)  # Add space between border and label

    def entry1(self):
        self.v = tk.StringVar()
        self.entry = tk.Entry(self.root, textvariable=self.v, font=24)
        self.entry.pack(fill="both", padx=5, pady=5)  # Add space between border and entry box
        self.entry.focus()

    def listbox(self):
        self.lv = tk.Variable()
        self.lst = tk.Listbox(self.root, listvariable=self.lv, height=13.5, width=16, selectbackground='#AE00FF')  # Set listbox height, width, and selection color
        self.lst.pack(side=tk.LEFT, fill=tk.BOTH, expand=1, padx=5, pady=5)  # Add space between border and listbox

    def label2(self):
        self.label = tk.Label(self.root, text="Press enter to add an item",
            bg='#FF00D0', anchor="w")  # Set label background color and anchor to left
        self.label.pack(fill="both", padx=5, pady=5)  # Add space between border and label

    def calendar(self):
        cal = Calendar(self.root, selectmode="day", year=2023, month=1, day=1, bg='#00A5FF', fg='white', height=13.5, width=16)  # Set calendar height, width, and background color
        cal.pack(side=tk.LEFT, padx=5, pady=5)  # Add space between border and calendar

    def message_boxes(self):
        self.copy_var = tk.IntVar()
        self.message1 = tk.Checkbutton(self.root, text="Copy to .config", variable=self.copy_var, bg='#FF00D0', anchor="ne")  # Set checkbox background color and anchor to top right
        self.message1.pack(fill="both", padx=5, pady=5)  # Add space between border and checkbox

    def install_button(self):
        install_button = tk.Button(self.root, text="Install", command=self.install, bg='#FF00D0')  # Set button background color
        install_button.pack(fill="both", padx=5, pady=5)  # Add space between border and button

    def binding(self):
        self.lst.bind("<Double-Button>", lambda x: self.delete(x))
        self.entry.bind("<Return>", lambda x: self.add(x))
        self.root.bind("<Control-s>", lambda x: self.save(x))

    def getdata(self):
        "grab saved data"
        filepath = os.path.join(os.path.dirname(__file__), "data.txt")  # Specify the correct path to data.txt
        if os.path.exists(filepath):
            with open(filepath) as file:
                for line in file:
                    self.lst.insert(tk.END, line.strip())

    def add(self, event):
        "add item to listbox with entry when Return is pressed"
        item_to_add = self.entry.get()
        if item_to_add:
            self.lst.insert(tk.END, item_to_add)
            self.v.set("")  # Clear the entry field
            self.save(event)

    def delete(self, event):
        "deletes items in listbox with double click on item"
        selected_item = self.lst.curselection()
        if selected_item:
            self.lst.delete(selected_item[0])
            self.save(event)

    def save(self, event):
        "saves memos in listbox"
        filepath = os.path.join(os.path.dirname(__file__), "data.txt")
        with open(filepath, "w") as file:
            for item in self.lst.get(0, tk.END):
                file.write(item + "\n")

    def install(self):
        # Implement your installation logic here
        pass

# Create an instance of the Window class
app_window = Window()