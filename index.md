@def title = "Franklin FAQ"

# Franklin FAQ

This website is meant to be a quick way to show how to do stuff that people ask, it will complement the [official documentation](https://franklinjl.org/).

It's not meant to be beautiful, rather just show how to get specific stuff done.

**Note**: an important philosophy here is that if you can write a Julia function that would produce the HTML you want, then write that function and let Franklin call it.

\toc



## (001) how to load data from file and loop over rows

This was asked on Slack with the hope it could mimick the [Data Files](https://jekyllrb.com/docs/datafiles/) functionality of Jekyll where you would have a file like

```
name,github
Eric Mill,konklone
Parker Moore,parkr
Liu Fengyun,liufengyun
```

and you'd want to loop over that and do something with it.

**Relevant pieces**:
* see `_assets/members.csv` (content is the code block above)

### Approach 1, with a `hfun`

* see `utils.jl` for the definition of `hfun_members_table`; calling `{{members_table _assets/members.csv}}` gives

{{members_table _assets/members.csv}}


### Approach 2, with a page variable and a for loop

* see `config.md` for the definition of the `members_from_csv` _global_ page variable.

Writing the following

```html
~~~
<ul>
{{for (name, alias) in members_from_csv}}
  <li>
    <a href="https://github.com/{{fill alias}}">{{fill name}}</a>
  </li>
{{end}}
</ul>
~~~
```

gives:

~~~
<ul>
{{for (name, alias) in members_from_csv}}
  <li>
    <a href="https://github.com/{{fill alias}}">{{fill name}}</a>
  </li>
{{end}}
</ul>
~~~

**Notes**:
* we use a _global_ page variable so that we don't reload the CSV file every single time something changes on the caller page.