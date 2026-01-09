import qsharp as qs
import os

project_root = os.path.dirname(os.path.abspath(__file__))
os.chdir(project_root)

qs.init(project_root='.', target_profile=qs.TargetProfile.Unrestricted)

print("Тебе нужно ввести число а квантовый компьютер его будет угадывать! от 1 до 20")


secret = input("Твое число: ")

try:
    num = int(secret)
except:
    print("Число введи")

for i in range (10):
    result = qs.eval(f"UC.FindSecretNumber({num, 20})")

    if (result == num) :
        print("Квантовый компьютер угадал, ты проиграл :(")
    else :
        print("Ты выиграл ^_^ :) !!!")
