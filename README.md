When you want to delete tons of small files in a directory, there are 2 ways:

* rm -rf /path/to/dir/*
* find /path/to/dir -name '\*.\*' -delete

If the above methods doesn't work for you (take long time to finish and cpu usage is high), then try the script "delete-lots-small-files.sh".

```bash
curl -sO 'https://raw.githubusercontent.com/xianhuazhou/delete-files/master/delete-lots-small-files.sh'
chmod +x delete-lots-small-files.sh
./delete-lots-small-files.sh /path/to/dir
```
