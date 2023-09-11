# Use an official Swift runtime image
FROM swift:5.8.1

# Copies the root directory of the repository into the image's filesystem at `/Linux`
ADD . /Linux

# Set the working directory to `/Linux`
WORKDIR /Linux

# List available plugins in Linux
RUN swift package plugin template
