import re

if __name__ == "__main__":
    print("\t\t\tText-Format-Menu\n")
    input_path = input("\tWhat file do you like to format : ")

    with open(input_path, 'r') as source_file_text:
        with open("formatted-text.txt", 'w+') as formatted_file_text:
            print("\n\t\tChoose a format option : \n\t1. Erase all punctuation marks;\n\t2. Erase multiple "
                  "spaces;\n\t3. Filter the numbers;\n\t0. Exit Format Menu.")

            while True:
                option_input = int(input("\nYour option : "))

                if option_input == 1:
                    # ~~ Parse by character ~~
                    #
                    # for ch in file_source_text.read():
                    #     if ch not in punctuation_marks: # (not in regex format)
                    #         file_formatted_text.write(ch)
                    #
                    # file_formatted_text.seek(0)  # move file pointer to beginning of file
                    # formatted_text = file_formatted_text.read()
                    # print(formatted_text)

                    # Parse with regex/
                    punctuation_marks = r'.?!:,-;()"\'-/'

                    formatted_file_text.seek(0)
                    formatted_file_text.truncate(0)
                    source_file_text.seek(0)

                    source_text = source_file_text.read()
                    pattern = '[' + re.escape(punctuation_marks) + ']'  # is useful if you want to match an arbitrary
                    # literal string that may have regular expression metacharacters in it; '[]' were added to transform
                    # the pattern variable into a re.Pattern object
                    formatted_text = re.sub(pattern, '', source_text)

                    formatted_file_text.write(formatted_text)
                    formatted_file_text.seek(0)
                    print(formatted_file_text.read())

                elif option_input == 2:
                    source_file_text.seek(0)
                    formatted_file_text.truncate(0)  # will truncate the file to zero bytes, effectively deleting its
                    # contents
                    formatted_file_text.seek(0)

                    pattern = re.compile(r' {2,}')
                    source_text = source_file_text.read()
                    formatted_text = re.sub(pattern, ' ', source_text)

                    formatted_file_text.write(formatted_text)
                    formatted_file_text.seek(0)
                    print(formatted_file_text.read())

                elif option_input == 3:
                    source_file_text.seek(0)
                    formatted_file_text.truncate(0)
                    formatted_file_text.seek(0)

                    pattern = re.compile(r'\d+')
                    source_text = source_file_text.read()

                    matches = re.findall(pattern, source_text)
                    for match in matches:
                        formatted_file_text.write(str(match) + ' ')

                    formatted_file_text.seek(0)
                    print(formatted_file_text.read())
                else:
                    print("\t\nProgram stopped !")
                    break