@echo off
echo "=====================�ύ=================================="
set BatDir=%~dp0
git pull
set/p log=�������ύ��־:

git add .
if "%log%"=="" (git commit -m "�Զ��ύ") else (git commit -m %log%)
git push

echo "===================�ύ�ɹ�================================"
pause