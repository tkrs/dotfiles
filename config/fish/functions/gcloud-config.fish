function gcloud-config
    set -l config (
      gcloud config configurations list --format='value(name,is_active)' |
      awk -F '\t' '{ print ($2 == "True" ? "* " : "  ") $1 }' |
      fzf --prompt='gcloud config> ' --height=40% --reverse |
      string sub -s 3
    )

    if test -z "$config"
        return
    end

    gcloud config configurations activate "$config"; or return

    set -l project (gcloud config get-value project 2>/dev/null)

    gcloud auth application-default login --disable-quota-project
    # and gcloud auth application-default set-quota-project "$project"
end
