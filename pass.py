import qsharp
import os

project_root = os.path.dirname(os.path.abspath(__file__))
os.chdir(project_root)

qsharp.init(project_root='.', target_profile=qsharp.TargetProfile.Unrestricted)

print("✅ Проект инициализирован")
try:
    length = int(input("Пожалуйста введите длину пароля: "))
except:
    print ("Введи число, а не букву")
useEntanglement = input("Использовать квантовую запутанность 2 кубитов?(1 (да) или 0(нет)): ")
if useEntanglement == "1":
    result = qsharp.eval(f"Pass.GeneratePassword({length, 1})")
elif useEntanglement == "0":
    result = qsharp.eval(f"Pass.GeneratePassword({length, 0})")
else:
    print ("1 или 0 ввести надо было, тогда без запутонности")
    result = qsharp.eval(f"Pass.GeneratePassword({length, 0})")


print(f"📊 Пароль: {result}")