#!/bin/bash
# 先同步远程仓库的更新
git pull --rebase --autostash
# 如果有冲突，需要手动解决
#if [ $? -ne 0 ]; then
#    echo "Pull failed. Please resolve conflicts manually."
#    exit 1
#fi
#
#执行数据库备份
#docker exec -it postgres pg_dump -U root  -d n8n  > n8n.sql
#echo "database backup successfully"
# 添加所有更改
git add .
# 检查是否有文件要提交
if git diff --staged --quiet; then
    echo "No changes to commit"
else
    # 提交更改
    git commit -m "sync MP"
    
    # 推送到远程仓库
    git push
    
    if [ $? -ne 0 ]; then
        echo "Push failed"
        exit 1
    fi
fi
echo "Backup completed successfully"
