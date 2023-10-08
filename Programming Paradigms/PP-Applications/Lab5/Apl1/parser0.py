import os
import tkinter as tk
import pygubu
import math
from multiprocessing import Process, Queue
from collections import deque

class Parser:
    ROOT_DIR = os.path.dirname(os.path.abspath(__file__))

    def __init__(self, master):
        self.master = master
        # 1: Create a builder
        self.builder = builder = pygubu.Builder()

        # 2: Load an ui file
        ui_path = os.path.join(self.ROOT_DIR, 'parser0.ui')
        builder.add_from_file(ui_path)

        # 3: Create the widget using a master as parent
        self.parser = builder.get_object('parser_frame', master)

        self.add_list_btn = self.builder.get_object('add_list_btn')
        self.list_of_integer_txt = self.builder.get_object('list_of_integers_txt')
        self.result_txt = self.builder.get_object("result_txt")
        self.filter_odd_btn = self.builder.get_object("filter_odd_btn")
        self.filter_primes_btn = self.builder.get_object("filter_primes_btn")
        self.sum_numbers_btn = self.builder.get_object("sum_numbers_btn")

        self.add_list_btn['command'] = self.add_list_process
        self.sum_numbers_btn['command'] = self.sum_list
        self.filter_odd_btn['command'] = self.filter_odds
        self.filter_primes_btn['command'] = self.filter_primes

        builder.connect_callbacks(self)

        self.message_queue = Queue()
        self.message_queue.put(deque([]))

        # self.integer_list = None

    def add_list(self):
        resultQ = self.message_queue.get()
        result = self.list_of_integer_txt.get("1.0", tk.END)
        result = result.strip().replace(' ', '')
        result = [int(item) for item in result.split(',')]

        self.integer_list = result

        self.result_txt.delete("1.0", tk.END)
        self.result_txt.insert("1.0", result)

        resultQ.append(result)
        resultQ.append("Process add_list exist")

    def add_list_process(self):
        process = Process(target=self.add_list)
        process.start()
        process.join()

    def sum_list(self):
        result = sum(self.integer_list)
        self.result_txt.delete("1.0", tk.END)
        self.result_txt.insert("1.0", result)

    def filter_odds(self):
        result = [odd for odd in self.integer_list if odd % 2 != 0]
        self.result_txt.delete("1.0", tk.END)
        self.result_txt.insert("1.0", result)

    def filter_primes(self):
        result = []

        for num in self.integer_list:
            if num == 0 or num == 1 or num == 2:
                continue

            contor = 0

            for i in range(2, int(math.sqrt(num))+1):
                if num % i == 0:
                    contor = 1

            if contor != 1:
                result.append(num)

    # result = [prime for prime in self.integer_list
    #           if all(prime % num != 0 for num in range(2, int(math.sqrt(prime) + 1)))]

        self.result_txt.delete("1.0", tk.END)
        self.result_txt.insert("1.0", result)

if __name__ == '__main__':
    root = tk.Tk()
    root.title('Exemplul 1 cu Tkinter si PyGubu')
    app = Parser(root)
    root.mainloop()
