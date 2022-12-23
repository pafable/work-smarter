import os
import argparse

API_KEY = 'eJ!uW7_CwbzJT2o&oX#JpBe%e'

parser = argparse.ArgumentParser(
    prog="Work-Smarter",
    description="Work Smarter app"
)

parser.add_argument(
    "-n",
    "--name",
    required=True
)

parser.add_argument(
    "-r",
    "--role",
    required=True
)

args = parser.parse_args()


class Files:
    def __init__(self, file_dir: str):
        self.file_dir = file_dir

    def get_files(self) -> list:
        if self.file_dir != None:
            return os.listdir(self.file_dir)
        raise ValueError("No directory was entered")

    @staticmethod
    def read_file(file: str):
        x = open(file)
        return x.read()


def greeting(name: str) -> str:
    return f"hello {name.capitalize()} and welcome to Work Smarter!"


def main():
    print(greeting(args.name))

    role = args.role
    if role.lower() == "mod":
        f = Files(os.getcwd())
        print("\nThese are the files you manage:")
        for index, file in enumerate(f.get_files()):
            print(f"{index}: {file}")

            if file == os.path.basename(__file__):
                print("\nReading file...")
                print(Files.read_file(file))


if __name__ == "__main__":
    main()
