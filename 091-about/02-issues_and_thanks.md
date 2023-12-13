

This section would introduce the tools chain as well as the issues / key points during building this book

#### Tools Chain
* `git`, `github`, `git pages` and `Action Workflow`, for code repo and deployment
* `gitboot`, and `gitbook-summary`, for pages generation 
* `node.js` and other plugins depended by `gitbook`


#### Key Points

##### Action Workflow

* An example of the job yaml is like this. 

```
name: auto-generate-gitbook 
on: 
    push: 
        branches: 
            - main

jobs:
    main-to-gh-pages: 
        runs-on: ubuntu-latest

        steps: 
            - name: checkout main 
              uses: actions/checkout@v3 
              with: 
                ref: main

            - name: install nodejs 
              uses: actions/setup-node@v1 

            - name: configue gitbook 
              run: | 
                npm install -g gitbook-cli 
                gitbook install 
                npm install -g gitbook-summary 

            - name: generate _book folder
              run: | 
                book sm 
                gitbook build 
                cp SUMMARY.md _book 

            - name: push _book to branch gh-pages 
              env:
                TOKEN: ${{ secrets.GITHUB_TOKEN }}
                REF: github.com/${{github.repository}}
                MYEMAIL: xxx@gmail.com
                MYNAME: ${{github.repository_owner}} 
                INITNAME: main  
              run: | 
                cd _book 
                git config --global user.email "${MYEMAIL}" 
                git config --global user.name "${MYNAME}" 
                git config --global init.defaultBranch "${INITNAME}"
                git init 
                git remote add origin https://${MYNAME}:${TOKEN}@${REF} 
                git add . 
                git commit -m "Build pages. TODO: get commit info from main branch" 
                git push --force --quiet origin main:gh-pages
```

* Pay attention to the version of `actions/setup-node`, if the version is too *HIGH*, for example, `v3`, there may be compatibility (between `node.js` and `gitbook`) issue. Refer to: 
    * https://stackoverflow.com/questions/64211386/gitbook-cli-install-error-typeerror-cb-apply-is-not-a-function-inside-graceful
    * https://github.blog/changelog/2022-09-22-github-actions-all-actions-will-begin-running-on-node16-instead-of-node12/

* Same, when use `gitbook` on local laptop, also pay attention to the version of `node.js`. Refer to:
    * https://blog.51cto.com/u_15127599/3304424


##### gitbook-summary

There are several tips which can make the work easier of this tool. For example,
* The parameters can be set by `book.json` file.
* The usage of `sortedBy` parameters. Refer to official `README`
* The usage of `readme.md` file when sorting. Refer to: https://github.com/imfly/gitbook-summary/issues/34


#### Thanks To

Great thanks to the author of this blog, especially for the `Action Workflow` part.
https://blog.csdn.net/qq_40889820/article/details/110013310
