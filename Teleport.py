import qsharp
import os

project_root = r'C:\Users\tim30\Desktop\quantum\Quant'
os.chdir(project_root)

qsharp.init(project_root='.', target_profile=qsharp.TargetProfile.Unrestricted)

print("✅ Проект инициализирован")
mode  = input("Введи число от 1 до 3 (1 и 2 (и более 4) - обычные режимы, 3 - режим в суперпозиции): ")
try:
    result = qsharp.eval(f"TP.RunTeleport({int(mode)})")
except:
    print("Надо было ввести число")
    result = "Числоооооо"
print(result)