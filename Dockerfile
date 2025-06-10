FROM jenkins/jenkins:lts

# Switch to root to install dependencies
USER root

# Copy the custom git plugin and rename it with .jpi extension
COPY my-custom-git-plugin.hpi /usr/share/jenkins/ref/plugins/my-custom-git-plugin.jpi

# Install required dependencies - let Jenkins resolve versions automatically
# Note: We're installing the dependencies but the custom plugin will override the default git plugin
RUN jenkins-plugin-cli --plugins \
    workflow-scm-step \
    workflow-step-api \
    credentials-binding \
    credentials \
    git-client \
    mailer \
    scm-api \
    script-security \
    ssh-credentials \
    structs

# Switch back to jenkins user
USER jenkins

# Skip the setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"