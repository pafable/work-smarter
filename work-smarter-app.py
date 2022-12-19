import os


class Files:
    def __init__(self, file_dir: str):
        self.file_dir = file_dir

    def get_files(self) -> list:
        if self.file_dir != None:
            return os.listdir(self.file_dir)
        raise ValueError("No directory was entered")


def main():
    f = Files(os.getcwd())
    for file in f.get_files():
        print(file)


if __name__ == "__main__":
    main()
